<?php

namespace App\Controller;

use App\Entity\User; // importante para @var User
use App\Entity\Video;
use App\Form\SearchType;
use App\Form\VideoType;
use App\Model\SearchData;
use App\Repository\VideoRepository;
use DateTimeImmutable;
use Doctrine\ORM\EntityManagerInterface;
use Knp\Component\Pager\PaginatorInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Contracts\Translation\TranslatorInterface; // corrigido namespace
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

final class VideoController extends AbstractController
{
    #[Route('/', name: 'app_video_index')]
    public function index(
        Request $request,
        VideoRepository $repository,
        PaginatorInterface $paginatorInterface,
        TranslatorInterface $translator
    ): Response {

        // barra de recherch
      $searchData = new SearchData();
      $searchData->page = $request->query->getInt('page', 1);


        $form = $this->createForm(SearchType::class, $searchData);
     $form->handleRequest($request);

    $videos = $repository->findBySeach($searchData);

    return $this->render('video/index.html.twig', [
        'form' => $form->createView(),
        'videos' => $videos,
        'videoTotal' => $videos->getTotalItemCount(), // pega total direto do paginator
    ]);




         if ($form->isSubmitted() && $form->isValid()) {
            // dd($searchData);
        }

        // Verificar email verificado do usuário logado (se houver)
        if ($this->getUser()) {
            /**
             *  @var User $user
             *  */
            // $user = $this->getUser();
            // if (!$user->isVerified()) {
            //     $this->addFlash('info', $translator->trans('videoController.emailNotVerified'));
            // }
        }



        $data = $repository->findAll();
        $videoTotal = sizeof($data);
        $videos = $paginatorInterface->paginate(
            $data,
            $request->query->getInt('page', 1),
            6
        );


           // barra de recherch
        $searchData = new SearchData();
        $form = $this->createForm(SearchType::class, $searchData);
        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            $searchData->page = $request->query->getInt('page', 1);
            // $videosList = $repository->findBySearch($searchData);
        }
        // else {
        //     $videosList = $repository->findAll();
        // }
       $videos = $repository->findBySeach($searchData);
       $videoTotal = sizeof($videos);

         return $this->render('video/index.html.twig', [
                'form' => $form,
                'videos' => $videos,
                'videoTotal' => $videoTotal,
            ]);




        return $this->render('video/index.html.twig', [
            'form' => $form->createView(),
            'videos' => $videos,
            'videoTotal' => $videoTotal,
        ]);
    }

    #[Route('/video/{id}', name: 'app_video_show', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function show(int $id, VideoRepository $repository): Response
    {
        $video = $repository->find($id);
        if (!$video) {
            throw $this->createNotFoundException('Vidéo non trouvée');
        }

        return $this->render('video/show.html.twig', [
            'video' => $video,
        ]);
    }

    #[Route('/video/{id}/edit', name: 'app_video_edit', methods: ['GET', 'POST'])]
    public function edit(Video $video, Request $request, EntityManagerInterface $em, TranslatorInterface $translator): Response
    {
        if ($this->getUser()) {
            /** @var User $user */
            $user = $this->getUser();
            if (!$user->isVerified()) {
                $this->addFlash('info', $translator->trans('videoController.edit.confirmEmail'));
                return $this->redirectToRoute('app_video_index');
            }
            if ($user->getEmail() !== $video->getUser()->getEmail()) {
                $this->addFlash('error', $translator->trans('videoController.edit.userVideo1') . $video->getUser()->getEmail() . $translator->trans('videoController.edit.userVideo2'));
                return $this->redirectToRoute('app_video_index');
            }
        } else {
            $this->addFlash('error', $translator->trans('videoController.edit.mustLogin'));
            return $this->redirectToRoute('app_login');
        }

        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $video->setUpdatedAt(new DateTimeImmutable());
            $em->flush();
            $this->addFlash('success', $translator->trans('videoController.edit.success'));

            return $this->redirectToRoute('app_video_show', [
                'id' => $video->getId(),
            ]);
        }

        return $this->render('video/edit.html.twig', [
            'video' => $video,
            'monForm' => $form->createView(),
        ]);
    }

    #[Route('/video/create', name: 'app_video_create')]
    public function create(Request $request, EntityManagerInterface $em, TranslatorInterface $translator): Response
    {
        if (!$this->getUser()) {
            $this->addFlash('error', $translator->trans('videoController.create.mustLogin'));
            return $this->redirectToRoute('app_login');
        }

        /** @var User $user */
        $user = $this->getUser();
        if (!$user->isVerified()) {
            $this->addFlash('error', $translator->trans('videoController.create.confirmEmail'));
            return $this->redirectToRoute('app_video_index');
        }

        $video = new Video();
        $form = $this->createForm(VideoType::class, $video);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $video->setUser($user)
                  ->setCreatedAt(new DateTimeImmutable())
                  ->setUpdatedAt(new DateTimeImmutable());

            $em->persist($video);
            $em->flush();

            $this->addFlash('success', $translator->trans('videoController.success.createVideo1') . ' ' . $video->getTitle() . $translator->trans('videoController.success.createVideo2'));

            return $this->redirectToRoute('app_video_index');
        }

        return $this->render('video/create.html.twig', [
            'monForm' => $form->createView(),
        ]);
    }

    #[Route('/video/{id}/delete', name: 'app_video_delete')]
    public function delete(Video $video, EntityManagerInterface $em, TranslatorInterface $translator): Response
    {
        if ($this->getUser()) {
            /** @var User $user */
            $user = $this->getUser();
            if (!$user->isVerified()) {
                $this->addFlash('error', $translator->trans('videoController.delete.confirmEmail'));
                return $this->redirectToRoute('app_video_index');
            }
            if ($user->getEmail() !== $video->getUser()->getEmail()) {
               $this->addFlash("error", "You must to be " . $video->getUser()->getEmail() . " to delete this Video !");
                return $this->redirectToRoute('app_video_index');
            }
        } else {
            $this->addFlash("error", "You must login to edit a Recipe !");
            return $this->redirectToRoute("app_login");
        }

        $title = $video->getTitle();

        $em->remove($video);
        $em->flush();

        $this->addFlash('info',' La Video ' . $title(). ' a été supprimée avec succès.');
    $translator->trans('videoController.delete.success',);

        return $this->redirectToRoute('app_video_index');
    }
}

