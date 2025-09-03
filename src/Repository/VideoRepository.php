<?php

namespace App\Repository;

use App\Entity\Video;
use Doctrine\ORM\Query;
use App\Model\SearchData;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Knp\Component\Pager\Pagination\PaginationInterface;
use Knp\Component\Pager\PaginatorInterface;

/**
 * @extends ServiceEntityRepository<Video>
 */

class VideoRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry,private PaginatorInterface $paginatorInterface)
    {
        parent::__construct($registry, Video::class);
    }


       /**
         *@return Video[] Returns an array of Recipe objects
         *cette methode permet de recuperer toutes les recettes qui ont une duree inferieure ou egale a la duree passee en parametre
         */

   

    /**
     *
     * @param SearchData $searchData
     * @return PaginationInterface
     */

       public function findBySearch(SearchData $searchData): PaginationInterface
       {

        $data =$this->createQueryBuilder('r')
        ->addOrderBy('r.createdAt', 'DESC');

        if (!empty($searchData->q)){
            $data = $data
                ->andWhere('r.title LIKE :q')
               ->setParameter('q', "%{$searchData->q}%");

        }

       $data = $data
        ->getQuery()
        ->getResult();

        $videos= $this->paginatorInterface->paginate($data, $searchData->page,9);


        return $videos;

       }
}
