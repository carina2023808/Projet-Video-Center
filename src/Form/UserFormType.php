<?php

namespace App\Form;

use App\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Vich\UploaderBundle\Form\Type\VichFileType;
use Vich\UploaderBundle\Form\Type\VichImageType;

class UserFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            // ->add('email')
            // ->add('roles')
            // ->add('password')
            ->add('firstname', TextType::class, [
                'label' => 'userFrom.firstname',
            ])
            ->add('lastname', TextType::class, [
                'label' => 'userFrom.lastname',
            ])
           ->add('imageFile', VichImageType::class, [
             'required' => false,
            'allow_delete' => true,
            'delete_label' => 'Delete profile image',
            'download_uri' => true,
            'image_uri' => true,
            'asset_helper' => true,
            'imagine_pattern' => 'avatar_thumbnail'
]);


            // ->add('isVerified')
            // ->add('createdAt', null, [
            //     'widget' => 'single_text',
            // ])
            // ->add('updatedAt', null, [
            //     'widget' => 'single_text',
            // ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => User::class,
        ]);
    }
}
