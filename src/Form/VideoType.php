<?php

namespace App\Form;

use App\Entity\Video;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class VideoType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title', TextType::class, [
                'label' => 'videoForm.title',
            ])
            ->add('videoLink', TextType::class, [
                'label' => 'videoForm.videoLink',
            ])
            ->add('description', TextType::class, [
                'label' => 'videoForm.description',
            ])
            // Caso queira exibir datas, descomente e use DateTimeType ou DateType
            // ->add('createdAt', DateTimeType::class, [
            //     'widget' => 'single_text',
            // ])
            // ->add('updatedAt', DateTimeType::class, [
            //     'widget' => 'single_text',
            // ])
            ->add('save', SubmitType::class, [
                'label' => 'recipeForm.save',
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Video::class,
        ]);
    }
}
